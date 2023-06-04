// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.20;

/// @title MevEthIndex
/// @notice This contract is used to store the events, and other data needed for off-chain indexing systems
contract MevEthIndex {
    /// ERC4626 events
    event Deposit(address indexed caller, address indexed owner, uint256 assets, uint256 shares);
    event Withdraw(address indexed caller, address indexed receiver, address indexed owner, uint256 assets, uint256 shares);

    event OracleUpdate(uint256 indexed prevBalance, uint256 prevValidators, uint256 newBalance, uint256 newValidators);
    event NewValidator(address indexed operator, bytes pubkey, bytes32 withdrawalCredentials, bytes signature, bytes32 deposit_data_root);
    event RewardsMinted(address indexed rewardsReceiver, uint256 feesAccrued);
    event StakingPaused();
    event StakingUnpaused();
    event FeeSet(uint256 indexed newFee);
    event FeeReceiverSet(address indexed newFeeReciever);
    event WithdrawalCredentialsSet(bytes32 indexed withdrawalCredentials);
    event MevEthSet(address indexed mevEthAddress);
    event OperatorRegistrySet(address indexed operatorRegistry);

    /// Errors
    error InsufficientBufferedEth();
    error TooManyValidatorRegistrations();
    error ExceedsStakingAllowance();
    error StakingIsPaused();
    error DepositTooLow();
    error ZeroShares();
    error ReportedBeaconValidatorsGreaterThanTotalValidators();
    error ReportedBeaconValidatorsDecreased();
    error BeaconDepositFailed();
    error InvalidWithdrawalCredentials();

    error OperatorsNotCommitted();
    error OperatorMaxValidatorsReached();
    error OperatorNotCommitted();
    error MaxValidatorError();
    error InvalidOperator();
    error ValidatorPreviouslyRegistered();
    error NotAuthorized();

    event OperatorCommited(address indexed operator);
    event OperatorUncommited(address indexed operator);
    event OperatorRemoved(address indexed operator);
    event OperatorMaxValidatorsSet(address indexed operator, uint256 maxValidators);

    /// @dev Node Operator parameters and internal state
    struct Operator {
        bool commited; // a flag indicating if the operator can participate in further staking
        uint64 maxValidators; // the maximum number of validators to stake for this operator
        uint64 validatorsActive; // number of active validators for this operator
    }

    /**
     * @dev Structure for passing information about the validator deposit data.
     * @param operator - address of the operator.
     * @param pubkey - BLS public key of the validator, generated by the operator.
     * @param withdrawal_credentials - withdrawal credentials used for generating the deposit data.
     * @param signature - BLS signature of the validator, generated by the operator.
     * @param deposit_data_root - hash tree root of the deposit data, generated by the operator.
     */
    struct ValidatorData {
        address operator;
        bytes pubkey;
        bytes32 withdrawal_credentials;
        bytes signature;
        bytes32 deposit_data_root; // more efficient to be calculated off-chain
    }

    uint256 public totalValidators;

    // Maps address to authorized Keepers
    mapping(address => bool) public keepers;

    // Maps address to Operator data
    mapping(address => Operator) public operatorData;

    // Maps hash of the validator data to whether it is registered.
    mapping(bytes32 => bool) public validators;
}
