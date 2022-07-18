/**
 * Errback utility type.
 *
 * @packageDocumentation
 * @internal
 * @hidden
 */
/**
 * Type representing a Node.js error-first callback.
 *
 * @param T - Type of the optional result value.
 *
 * @internal
 * @hidden
 */
export declare type Errback<T = never> = (err: Error | null, result?: T) => void;
//# sourceMappingURL=errback.d.ts.map